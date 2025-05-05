Geocoder.configure(
  lookup: :nominatim,
  http_headers: { 'User-Agent' => 'fortytools' },
  units: :km,
  timeout: 5,
  nominatim: {
    host: 'nominatim.openstreetmap.org',
    scheme: 'https'
  }
)

