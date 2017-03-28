    if k == num_folders
        analyzed_files = length (ROI_ill_all);
        X = ['You''re done. No further files to analyze in this directory! You analyzed ',num2str(analyzed_files),' files out of ' num2str(i) ' files'];
        disp (X)
    end