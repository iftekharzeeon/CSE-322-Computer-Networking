//import java.io.*;
//import java.net.Socket;
//import java.util.Scanner;
//
//public class ClientInitiate {
//
//    private static final String SERVER_IP = "localhost";
//    private static final int SERVER_PORT = 5038;
//
//    private static Socket socket;
//    private static PrintWriter printWriter;
//    private static BufferedReader bufferedReader;
//    private static DataOutputStream out = null;
//    public static void main(String[] args) {
//
//        try {
//            socket = new Socket(SERVER_IP, SERVER_PORT);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        try {
//            printWriter = new PrintWriter(socket.getOutputStream());
//            bufferedReader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
//            out = new DataOutputStream(socket.getOutputStream());
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        while (true) {
//            System.out.println("Enter the file name you want to upload");
//            Scanner scanner = new Scanner(System.in);
//            String input = scanner.nextLine();
//            if (input.equals("exit")) {
//                break;
//            }
//            new Client_2(input, socket, printWriter, bufferedReader, out);
//        }
//
//        //Closing
//        try {
//            bufferedReader.close();
//            printWriter.close();
//            socket.close();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//    }
//}
