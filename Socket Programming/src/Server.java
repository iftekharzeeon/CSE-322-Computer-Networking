import java.io.*;
import java.net.*;

public class Server {
    public static final String LOG_DIRECTORY = "D:\\Varsity\\Courses\\3-2\\CSE 322\\Socket Programming\\log directory";

    private ServerSocket serverSocket;
    Server(){
        try{
            File logFiles = new File(LOG_DIRECTORY);
            if (logFiles.exists()) {
                File[] files = logFiles.listFiles();
                for (File file : files) {
                    file.delete();
                }
                logFiles.delete();
            }
            logFiles.mkdir();
            serverSocket = new ServerSocket(5038);
            while(true) {
                System.out.println("Waiting for client");
                Socket clientSocket = serverSocket.accept();
                System.out.println("Client connected");
                serve(clientSocket, logFiles);
            }
        }catch (IOException e){
            System.out.println("Server starts : "+e);
        }
    }
    public void serve(Socket clientSocket, File logFiles){
        NetworkUtil networkUtil = new NetworkUtil(clientSocket);
        new HttpFileServer(networkUtil, logFiles);
    }
    public static void main(String[] args) {
        Server server = new Server();
    }
}
