# APPは、アプリケーション内で参照する際の、変数名を指す。
# /config/app.ymlは、アプリケーション独自の設定項目と値のマッピングファイルを指す。
APP = YAML.load(File.read("#{Rails.root}/config/app.yml"))[Rails.env]
