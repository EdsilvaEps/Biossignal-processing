function [resampled_spiro] = resample_spiro(folder_path)

    raw_spiro_path = fullfile(folder_path, "spirometer.txt");

    raw_spiro = load(raw_spiro_path);

    resampled_spiro = resample(raw_spiro, 50, 100);

end