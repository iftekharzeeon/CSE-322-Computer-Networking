//import java.io.IOException;
//import java.net.ServerSocket;
//
//public class ServerInitiate {
//
//    private static final int SERVER_PORT = 5038;
//    private static final String SERVER_ADDRESS = "http://localhost:" + SERVER_PORT;
//
//    public static void main(String[] args) throws IOException {
//        //Http Server started at port 5038
//        ServerSocket serverSocket = new ServerSocket(SERVER_PORT);
//        System.out.println("Server started at port 5038");
//        //Server starting to accept
//        while (true) {
//            new HttpFileServer_2(serverSocket.accept(), SERVER_ADDRESS);
//        }
//    }
//}
