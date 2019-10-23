require "json"
require "net/http"
require "uri"

q = ARGV[0]
# sprintfは、指定のフォーマットに値を埋め込んだ文字列を作成する。
target_uri = sprintf(
    "https://api.github.com/search/repositories?q=%s in:name&sort=stars&order=desc",
    q)
#target_uri = "https://api.github.com/"
# URI.parseは、URL文字列を元にURIオブジェクトを作成する。
uri = URI.parse(target_uri)
puts(uri)


# Net::HTTP.newは、Net::HTTPオブジェクトを作成する。
# 第1引数は、接続するホスト名を指定する。
# 第2引数は、接続するポート番号を指定する。
http = Net::HTTP.new(uri.hostname, uri.port)
# SSL通信の場合、use_sslをtrueに設定する。
http.use_ssl = true
# Net::HTTP::Get.newは、HTTPリクエストオブジェクトを作成する。
# 第1引数は、リクエストするURLを指定する。
req = Net::HTTP::Get.new(uri.request_uri)
# HTTP.requestは、リクエストを実行する。
# 第1引数は、リクエストオブジェクトを指定する。
response = http.request(req)
#puts(response.body)

# Response.bodyメソッドは、レスポンスボディを参照する。
# JSON.parseメソッドは、JSON形式の文字列をRubyオブジェクトに変換する。
repositories = JSON.parse(response.body)
# JSON.parseの返却値は、HashやArrayで構成される。
items = repositories["items"]
items.each do |item|
    puts("id:" + item["id"].to_s + ", name:" + item["name"])
end
