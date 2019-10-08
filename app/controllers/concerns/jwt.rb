module Jwt

    extend ActiveSupport::Concern

    def issue

        # ペイロードを作成する。
        payload = {
            data: "test"
        }
        # 文字列形式の秘密鍵をロードする。
        rsa_private = OpenSSL::PKey::RSA.new APP["private"]
        # JWT.encodeは、トークンを作成する。
        # 第1引数は、ペイロードを指定する。
        # 第2引数は、秘密鍵を指定する。
        # 第3引数は、署名アルゴリズムを指定する。
        token = JWT.encode payload, rsa_private, 'RS256'
        
    end

    def validate(token)

        # 文字列形式の秘密鍵を元に、公開鍵を取得する。
        rsa_public = (OpenSSL::PKey::RSA.new APP["private"]).public_key
        # トークンをデコード（検証）する。
        # 第1引数は、トークンを指定する。
        # 第2引数は、公開鍵を指定する。
        # 第3引数は、trueを指定する
        # 第4引数は、オプション（署名アルゴリズム）を指定する。
        # 期限切れ等で検証に失敗した場合は、例外が発生する。
        decoded = JWT.decode(
            token,
            rsa_public,
            true,
            { algorithm: 'RS256' })

    end

end
