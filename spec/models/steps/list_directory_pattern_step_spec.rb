require 'rails_helper'

describe Steps::ListDirectoryPatternStep do
  it "globs all the files that match the given pattern" do
    expected = ["#{Rails.root}/Gemfile", "#{Rails.root}/Gemfile.lock"]
    expect(dir_data_source(File.join(Rails.root, "*")).perform.map(&:payload)).to include(*expected)
  end

  def dir_data_source(glob)
    described_class.new glob: glob
  end
end
