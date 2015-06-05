require 'rails_helper'
require 'securerandom'

describe Steps::UniqueBlobStep do
  let(:message) do
    Message.wrap('id' => SecureRandom.uuid)
  end

  it 'saves a blob to the database' do
    expect { unique_blob_step.perform_one(message).to_a }.to change { Blob.count }.by(1)
    expect(Blob.last.data).to eq message.payload
  end

  it 'sets the unique id for the blob' do
    unique_blob_step.perform_one(message).to_a
    expect(Blob.last.unique_id).to eq message.payload['id']
  end

  it 'sets the tag for the blob' do
    unique_blob_step.perform_one(message).to_a
    expect(Blob.last.tag).to eq 'tag'
  end

  it 'yields the current record' do
    expect(unique_blob_step.perform_one(message).first).to eq message
  end

  it 'does not yield a duplicate record' do
    step = unique_blob_step
    expect(step.perform_one(message).first).to eq message
    expect(step.perform_one(message).first).to be_nil
  end

  def unique_blob_step(unique_id_field = 'id', tag = 'tag')
    described_class.create unique_id_field: unique_id_field, tag: tag
  end
end
