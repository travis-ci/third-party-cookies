require 'base64'

app = proc do |env|
  if env['PATH_INFO'] == '/check'
    enabled = (!!(env['HTTP_COOKIE'].to_s =~ /foo=bar/))
    headers = { 'Set-Cookie' => 'foo=', 'Content-Type' => 'application/javascript' }
    [200, headers, ["cookiesCheckCallback(#{enabled});"]]
  elsif env['PATH_INFO'] == '/set'
    blank_gif = Base64.decode64 'R0lGODlhBQAFAJH/AP///wAAAMDAwAAAACH5BAEAAAIALAAAAAAFAAUAAAIElI+pWAA7\n'
    [200, { 'Content-Type' => 'image/gif', 'Set-Cookie' => 'foo=bar' }, [blank_gif]]
  end
end

run app
