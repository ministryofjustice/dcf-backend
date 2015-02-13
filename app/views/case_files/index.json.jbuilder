json.array!(@case_files) do |case_file|
  json.extract! case_file, :id, :urn, :blob
  json.url case_file_url(case_file, format: :json)
end
