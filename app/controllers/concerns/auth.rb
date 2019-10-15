module Auth

    extend ActiveSupport::Concern

    include Jwt

    # トークンの検証によるユーザ認証を実施する。
    def authenticate(request_headers)
        token = request_headers["Authorization"]
        decoded = nil
        err = nil
        begin
            decoded = validate(token)
        rescue => e
            err = e
        end
        [decoded, err]
    end

end
