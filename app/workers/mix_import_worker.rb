class MixImportWorker
  include Sidekiq::Worker

  def perform(file)
    Mix.import(file)
  end
end