function evaluate_model_perfomance(folder_path)

    belt_signals_path = fullfile(folder_path, "beltsignals.txt");
    belt = load(belt_signals_path);

    spiro_sig = resample_spiro(folder_path);

    [ln_flow, quad_flow, int_flow] = predict_resp_airflows(folder_path);

    spiro_mean = mean(spiro_sig);
    ln_flow_mean = mean(ln_flow);
    quad_flow_mean = mean(quad_flow);
    int_flow_mean = mean(int_flow);
    N = length(spiro_sig);

    % compute correlation coefficients between the predicted respiratory airflow signals and the spirometer signal

    R_ln_flow = corr(ln_flow, spiro_sig)

    R_quad_flow = corr(quad_flow, spiro_sig)

    R_int_flow = corr(int_flow, spiro_sig)

    % Compute RMSE values

    % linear flow model
    ln_ss_err = sum((spiro_sig - ln_flow).^2);
    ln_mse = ln_ss_err / N;
    ln_rmse = sqrt(ln_mse)

    % quadratic flow model
    quad_ss_err = sum((spiro_sig - quad_flow).^2);
    quad_mse = quad_ss_err / N;
    quad_rmse = sqrt(quad_mse)

    % interactive flow model
    int_ss_err = sum((spiro_sig - int_flow).^2);
    int_mse = int_ss_err / N;
    int_rmse = sqrt(int_mse).^2

    t = ( 0:size(belt,1)-1 ) / 50;
    figure
    subplot(211)
    plot(t, spiro_sig, 'k')
    hold on
    plot(t, ln_flow, 'r')
    plot(t, quad_flow, 'b')
    plot(t, int_flow, 'g')
    title('Measured and predicted flows')
    xlabel('time [s]')
    ylabel('flow [ml/s]')
    legend('Spirometer (resampled)', 'Model 1', 'Model 2', 'Model 3')
    subplot(212)
    title('Belt signals')
    plot(t, belt(:,1), 'b')
    hold on
    plot(t, belt(:,2), 'g')
    xlabel('time [s]')
    ylabel('respiratory effort [a.u.]')
    legend('Belt 1', 'Belt 2')
    ylim([-700 700])
        


end