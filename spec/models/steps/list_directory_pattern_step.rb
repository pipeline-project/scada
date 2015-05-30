require 'rails_helper'

describe Steps::ListDirectoryPatternStep do
  it "globs all the files that match the given pattern" do
    expect(dir_data_source(File.join(Rails.root, "*")).perform).to include "#{Rails.root}/Gemfile", "#{Rails.root}/Gemfile.lock"
  end

  def dir_data_source(glob)
    described_class.new glob: glob
  end
end
