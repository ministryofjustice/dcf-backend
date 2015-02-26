json.array!(@case_files) do |case_file|
  json.extract! case_file, :id, :urn_code, :blob
end
