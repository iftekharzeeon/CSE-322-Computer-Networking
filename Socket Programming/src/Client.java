public class Client {
    Client(String serverAddress, int serverPort){
        try {
//            NetworkUtil networkUtil = new NetworkUtil(serverAddress, serverPort);
//            new WriteClient(networkUtil);
            new WriteClient(serverAddress, serverPort);
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        String serverAddress = "127.0.0.1";
        int serverPort = 5038;
        Client client = new Client(serverAddress, serverPort);
    }
}
