if Rails.env === 'production' 
    Rails.application.config.session_store :cookie_store, key: '_photo_35mm_api', domain: 'photo_35mm_api-json-api'
  else
    Rails.application.config.session_store :cookie_store, key: '_photo_35mm_api'

  end 