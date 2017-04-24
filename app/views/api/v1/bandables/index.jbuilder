json.array! @bandables do |bandable|
  json.partial! 'api/v1/bandables/bandable', bandable: bandable
end