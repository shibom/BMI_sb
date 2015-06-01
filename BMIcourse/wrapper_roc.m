Nt = [50,100,250,500,1000,1500,2000,2500,3000,3200];
figure; leg_info = {};
for k=1:length(Nt)
    class_jg = get_training_data_v2(Nt(k));
    [truth_labels, scores] = detect_polyps(class_jg);
    [fpr,tpr, ~, auc] = perfcurve(truth_labels, scores(:, 2), 'p');
    plot(fpr,tpr, 'LineWidth', 2); hold all;
    xlabel('False Positive Rate', 'FontSize', 14, 'FontWeight', 'bold');
    ylabel('True Positive Rate', 'FontSize', 14, 'FontWeight', 'bold');
    leg_info{k} = [num2str(Nt(k)),' Trees; AUC:', (num2str(auc))];
end
legend(leg_info); hold all;