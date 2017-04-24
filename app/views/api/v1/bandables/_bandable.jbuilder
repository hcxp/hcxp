json.extract! bandable, :id, :band_id, :bandable_type, :bandable_id, :created_at, :updated_at

json.band do
  json.partial! 'api/v1/bands/band', band: bandable.band
end