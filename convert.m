% フォルダパスを指定
folderPath = 'data/input';   % .matファイルがあるフォルダのパス
outputPath = 'data/output'; % CSVファイルの出力先フォルダのパス

% フォルダ内のすべての.matファイルを取得
matFiles = dir(fullfile(folderPath, '*.mat'));

% 各.matファイルに対して処理を行う
for i = 1:length(matFiles)
    % .matファイルを読み込む
    fileName = matFiles(i).name;
    filePath = fullfile(folderPath, fileName);
    FileData = load(filePath);
    
    % ファイル名から拡張子を除いた部分を取得
    [~, baseName, ~] = fileparts(fileName);
    
    % 構造体のフィールドを処理
    fields = fieldnames(FileData);
    for K = 1:length(fields)
        thisvar = fields{K};
        thisdata = FileData.(thisvar);
        
        if ~isnumeric(thisdata)
            warning('Skipping field %s in file %s which is type %s instead of numeric', thisvar, fileName, class(thisdata));
            continue;
        end
        
        % データを列ベクトルに変換(既に1列の場合はそのまま)
        valueData = thisdata(:);
        
        % 小数点以下4桁に丸める処理を追加
        valueData = round(valueData * 10000) / 10000;
        
        % CSVファイル名を生成(タイムスタンプを含めない_
        thisfile = sprintf('%s_%s.csv', baseName, thisvar);
        
        % CSVファイルを出力フォルダに保存
        try
            csvwrite(fullfile(outputPath, thisfile), valueData);
            fprintf('Saved %s\n', thisfile);
        catch ME
            warning('Failed to save file %s: %s', thisfile, ME.message);
        end
    end
end

fprintf('処理が完了しました。\n');
