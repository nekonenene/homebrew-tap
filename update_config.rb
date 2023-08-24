require "digest/sha2"
require "json"
require "net/http"
require "uri"

class ConfigSet
  attr_reader :os_type, :cpu_type, :filename, :url, :sha256_hash

  def initialize(os_type:, cpu_type:, github_url:, version:, filename_template:)
    @os_type = os_type
    @cpu_type = cpu_type
    @filename = filename_template.sub("{os}", os_type).sub("{cpu}", cpu_type)
    @url = "#{github_url}/releases/download/#{version}/#{@filename}"
    @sha256_hash = fetch_sha256(@url)
  end

  private

  # Return SHA256 hash string or nil
  def fetch_sha256(url)
    response_body =
      loop do
        is_loop_end = true

        uri = URI.parse(url)
        response = Net::HTTP.get_response(uri)

        case response
        when Net::HTTPSuccess
          break response.body
        when Net::HTTPNotFound
          puts "Not found: \"#{url}\""
        when Net::HTTPRedirection
          url = response["location"]
          is_loop_end = false
        else
          puts "#{response.code} error occured while connecting to \"#{url}\""
        end

        break if is_loop_end
      end

    Digest::SHA256.hexdigest(response_body) if !response_body.nil?
  end
end

class UpdateConfig
  def main
    json_file_path = ARGV[0]
    if json_file_path.nil? || !json_file_path.end_with?(".json")
      puts "[ERROR] Please specify the JSON file path like \"configs/abc.json\"."
      exit 1
    end

    body =
      begin
        File.read(json_file_path)
      rescue
        puts "[ERROR] Failed to open the file."
        exit 1
      end

    json_body = JSON.parse(body)

    begin
      inputs = json_body["inputs"]
      raise "[ERROR] Could not find key \"inputs\" in JSON" if inputs.nil?
      github_url = inputs["github_url"]&.delete_suffix("/")
      raise "[ERROR] Could not find key \"github_url\" in \"inputs\"" if github_url.nil?
      version = inputs["version"]
      raise "[ERROR] Could not find key \"version\" in \"inputs\"" if version.nil?
      filename_template = inputs["filename_template"]
      raise "[ERROR] Could not find key \"filename_template\" in \"inputs\"" if filename_template.nil?
    rescue => e
      puts e
      exit 1
    end

    outputs = {}
    for os_type in %w[Darwin Linux] do
      outputs[os_type] = {}

      for cpu_type in %w[x86_64 arm64] do
        print "."
        outputs[os_type][cpu_type] = {}

        config = ConfigSet.new(os_type: os_type, cpu_type: cpu_type, github_url: github_url, version: version, filename_template: filename_template)
        outputs[os_type][cpu_type]["url"] = config.url
        outputs[os_type][cpu_type]["sha256"] = config.sha256_hash
      end
    end

    merged_hash = { "inputs" => inputs, "outputs" => outputs }
    json = JSON.pretty_generate(merged_hash)

    File.write(json_file_path, json)
    puts "Finished!"
  end
end

UpdateConfig.new.main
