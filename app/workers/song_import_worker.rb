class SongImportWorker
  include Sidekiq::Worker

  def perform(file)
    Song.import(file)
  end
end