module AppHash

    extend ActiveSupport::Concern

    # 平文パスワードをハッシュ化する。
    def hash_password(plain_password)
        Digest::SHA256.hexdigest plain_password
    end

end
