function [linear_model_flow, quadratic_model_flow, interaction_model_flow] = predict_resp_airflows(folder_path)

    % raw_spiro_path = fullfile(folder_path, "spirometer.txt");
    linear_coefficients_path = fullfile(folder_path, "regressioncoefficients1.txt");
    quadratic_coefficients_path = fullfile(folder_path, "regressioncoefficients2.txt");
    interaction_coefficients_path = fullfile(folder_path, "regressioncoefficients3.txt");
    belt_signals_path = fullfile(folder_path, "beltsignals.txt");

    % spiro_resampled = resample_spiro(raw_spiro_path);
    % summary(spiro_resampled)

    linear_coeffs = load(linear_coefficients_path);
    quadratic_coeffs = load(quadratic_coefficients_path);
    interaction_coeffs = load(interaction_coefficients_path);
    belt_signal = load(belt_signals_path);
    %summary(belt_signal);

    % separating the belt signals
    chest_signal = belt_signal(:,1);
    abdoment_signal = belt_signal(:,2);

    % linear model (can be done using filtlm, mdl or setwiselm instead)
    linear_model_flow = linear_coeffs(1)*chest_signal + linear_coeffs(2)*abdoment_signal; 
    summary(linear_model_flow);

    % quadratic model
    quadratic_model_flow = quadratic_coeffs(1)*chest_signal + quadratic_coeffs(2)*abdoment_signal ...
                             + quadratic_coeffs(3)*chest_signal.^2 + quadratic_coeffs(4)*abdoment_signal.^2;
    summary(quadratic_model_flow); 

    % interaction model
    interaction_model_flow = interaction_coeffs(1)*chest_signal + interaction_coeffs(2)*abdoment_signal ...
                                + interaction_coeffs(3)*(chest_signal.*abdoment_signal);
    summary(interaction_model_flow);


end
