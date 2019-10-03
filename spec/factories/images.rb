FactoryBot.define do
  factory :image do
    name   {Rack::Test::UploadedFile.new(Rails.root.join('spec/support/sample-image/excalibur.jpeg'))}
  end
end