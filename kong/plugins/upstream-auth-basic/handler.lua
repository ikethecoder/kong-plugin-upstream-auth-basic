local plugin = {
  PRIORITY = 850,
  VERSION = "1.0.0",
}

function plugin:access(conf)

  local username = conf.username
  local password = conf.password or ''

  local auth_string = username .. ':' .. password;

  local auth_string_base64 = ngx.encode_base64(auth_string);
  local auth_header = "Basic " .. auth_string_base64;
  kong.service.request.set_header("Authorization", auth_header)

end

function plugin:header_filter(conf)
  
  -- maybe remove the authorization header?
  
end

return plugin
