function [resampled_spiro] = resample_spiro(input_file)

    raw_spiro = load(input_file);

    resampled_spiro = resample(raw_spiro, 50, 100);

end