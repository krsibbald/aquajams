require 'csv'
require 'open-uri'

class ImportWorker
  include Sidekiq::Worker

  def file_name_from_file(file)
    if file.respond_to?(:match) && file.match(/\Ahttp/)
      file = open(file)
    end

    file_name = file.respond_to?(:path) ? file.path : file
    file_name
  end
 
  def perform(file)
    raise "Abstract class"
  end
end