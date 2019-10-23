target_dir = ARGV[0]
puts(target_dir)
# Dir.entiesは、指定ディレクトリ内の全ファイルエントリ名を文字列配列で返却する。
fileContents = Dir.entries(target_dir)
fileContents.each do |fileContent|
    puts(fileContent)
end
