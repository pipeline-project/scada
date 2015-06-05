require 'rails_helper'

describe Steps::StoreBlobStep do
  let(:message) do
    Message.wrap('id' => '1')
  end

  it 'saves a blob to the database' do
    expect { store_blob_step.perform_one(message) }.to change { Blob.count }.by(1)
    expect(Blob.last.data).to eq 'id' => '1'
  end

  it 'sets the unique id for the blob' do
    store_blob_step.perform_one(message)
    expect(Blob.last.unique_id).to eq '1'
  end

  it 'sets the tag for the blob' do
    store_blob_step.perform_one(message)
    expect(Blob.last.tag).to eq 'tag'
  end

  it 'yields the current record' do
    expect(store_blob_step.perform_one(message)).to eq message
  end

  def store_blob_step(unique_id_field = 'id', tag = 'tag')
    described_class.new unique_id_field: unique_id_field, tag: tag
  end
end
