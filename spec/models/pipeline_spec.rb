require 'rails_helper'

describe Pipeline do
  it 'should kinda work' do
    subject.steps << Steps::IdentityStep.new(pipeline: subject)
    subject.steps << Steps::IdentityStep.new(pipeline: subject)

    actual = subject.perform([1, 2, 3]).to_a
    expect(actual).to match_array [1, 2, 3]
  end

  it 'should kinda work with enumerables' do
    subject.steps << Steps::ListDirectoryPatternStep.new(pipeline: subject, glob: File.join(Rails.root, '*'))

    actual = subject.perform.to_a
    expect(actual).to include File.join(Rails.root, 'Gemfile')
    expect(actual).to include File.join(Rails.root, 'Rakefile')
  end

  it 'should be able to do something useful' do
    subject.steps << Steps::GsubStep.new(pipeline: subject,
                                         pattern: '^(.+)$',
                                         replacement: 'http://purl.stanford.edu/\1.xml')
    subject.steps << Steps::HttpRequestStep.new(pipeline: subject)
    subject.steps << Steps::ItemLevelStep.new(pipeline: subject, level: 'body')
    subject.steps << Steps::ItemLevelXpathStep.new(pipeline: subject, xpath: '//identityMetadata')
    subject.steps << Steps::XpathStep.new(pipeline: subject, xpath: {
                                            id: '//objectId/text()',
                                            sourceId: '//sourceId/text()',
                                            label: '//objectLabel/text()',
                                          })
    subject.steps << Steps::GsubStep.new(pipeline: subject, pattern: 'druid:', replacement: '', fields: 'id')
    subject.steps << Steps::ConstantValueStep.new(pipeline: subject, value: ->() { Time.now }, fields: 'pipelined_at')
    # subject.steps << Steps::HttpPostRequestStep.new(subject, url: 'http://localhost:8983/solr/update')

    actual = subject.perform(['xf680rd3068']).first
    expect(actual).to include 'id' => ['xf680rd3068'],
                              'sourceId' => ['MISC_1855'],
                              'label' => ['Latin glossary : small manuscript fragment on vellum.']
    expect(actual).to include 'pipelined_at'
  end
end
