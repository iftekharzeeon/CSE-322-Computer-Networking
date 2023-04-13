import java.util.Scanner;

public class WriteClient implements Runnable{

    private Thread thr;
    private NetworkUtil networkUtil;
    private String fileName;
    private String serverAddress;
    private int serverPort;

    public WriteClient(NetworkUtil networkUtil) {
        this.networkUtil = networkUtil;
        this.thr = new Thread(this);
        thr.start();
    }

    public WriteClient(String serverAddress, int serverPort) {
        this.serverPort = serverPort;
        this.serverAddress = serverAddress;

        while(true)  {
            System.out.println("Enter the filename you want to upload: ");
            Scanner input = new Scanner(System.in);
            fileName = input.nextLine();

            this.thr = new Thread(this);
            thr.start();
        }


    }

    public void run() {
            try {
                this.networkUtil = new NetworkUtil(serverAddress, serverPort);
                this.networkUtil.writeFromClient(fileName);
            } catch (Exception e) {
                System.out.println(e);
            }
            finally {
                this.networkUtil.closeConnection();
            }
    }
}
