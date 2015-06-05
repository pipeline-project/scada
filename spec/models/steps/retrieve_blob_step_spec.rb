require 'rails_helper'

describe Steps::RetrieveBlobStep do
  let! :blob do
    Blob.create unique_id: 'x', data: { id: 1 }, tag: 'tag'
  end

  it 'retrieves a blob from the database' do
    actual = retrieve_blob_step.perform_one(Message.new).first
    expect(actual.payload).to eq blob.data
  end

  def retrieve_blob_step(tag = 'tag')
    described_class.new tag: tag
  end
end
