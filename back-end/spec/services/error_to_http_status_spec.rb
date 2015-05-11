require 'rails_helper'

describe ErrorToHttpStatus do
  cases = {
    NoBrainer::Error::DocumentNotFound.new => 404,
    StandardError.new => 500,
  }

  cases.each do |error, status|
    it "returns #{status} for #{error.inspect}" do
      expect(described_class[error]).to eq(status)
    end
  end
end
