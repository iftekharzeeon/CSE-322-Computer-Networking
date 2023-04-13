public class ReadClient implements Runnable{
    private Thread thr;
    private NetworkUtil networkUtil;

    public ReadClient(NetworkUtil networkUtil) {
        this.networkUtil = networkUtil;
        this.thr = new Thread(this);
        thr.start();
    }

    public void run() {
        try {
            while (true) {
                String responseFromServer = networkUtil.read();
                if (responseFromServer != null) {
                    System.out.println("FROM SERVER: " + responseFromServer);
                }
            }
        } catch (Exception e) {
            System.out.println("ReadClient Error: "+e);
        } finally {
            networkUtil.closeConnection();
        }
    }
}
