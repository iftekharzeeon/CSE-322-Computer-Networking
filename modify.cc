double REDQueue::estimator(int nqueued, int m, double ave, double q_w)
{
	double new_ave;

	new_ave = ave;

	if (edp_.is_modifiedRed) {
		// Modified RED is working
		new_ave = (1.0 - q_w) * new_ave + q_w * nqueued;
	} else {
		//Default RED is working
		while (--m >= 1) {
			new_ave *= 1.0 - q_w;
		}
		new_ave *= 1.0 - q_w;
		new_ave += q_w * nqueued;
	}
	
	double now = Scheduler::instance().clock();
	if (edp_.adaptive == 1) {
		if (edp_.feng_adaptive == 1)
			updateMaxPFeng(new_ave);
		else if (now > edv_.lastset + edp_.interval)
			updateMaxP(new_ave, now);
	}
	return new_ave;
}
