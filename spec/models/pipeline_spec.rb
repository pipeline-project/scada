require 'rails_helper'

describe Pipeline do
  it 'should kinda work' do
    subject.steps << Steps::IdentityStep.new(subject)
    subject.steps << Steps::IdentityStep.new(subject)

    actual = subject.perform([1, 2, 3]).to_a
    expect(actual).to match_array [1, 2, 3]
  end

  it 'should kinda work with enumerables' do
    subject.steps << Steps::ListDirectoryPatternStep.new(subject)

    actual = subject.perform(File.join(Rails.root, '*')).to_a
    expect(actual).to include File.join(Rails.root, 'Gemfile')
    expect(actual).to include File.join(Rails.root, 'Rakefile')
  end
end
