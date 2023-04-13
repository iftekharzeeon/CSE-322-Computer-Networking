//
//import NetworkUtil;
//
//import java.util.ArrayList;
//import java.util.HashMap;
//
//public class ReadServer implements  Runnable{
//    private Thread thr;
//    private NetworkUtil networkUtil;
//    public static HashMap<NetworkUtil, ArrayList<String>> activeUsersMap = new HashMap<>();
//
//    public ReadServer(NetworkUtil networkUtil) {
//        this.networkUtil = networkUtil;
//        this.thr = new Thread(this);
//        thr.start();
//    }
//
//    public void run() {
//        try {
//            while (true) {
//                Object o = networkUtil.read();
//                if(o!=null) {
//                    String text = (String) o;
//                    String[] split_text = text.split("#");
//                    if(split_text[0].equals("L")){
//                        new LMessage(networkUtil,split_text);
//                    } else if(split_text[0].equals("S")){
//                        new SMessage(activeUsersMap, networkUtil, split_text);
//                    } else if(split_text[0].equals("B")) {
//                        new BMessage(activeUsersMap, networkUtil, split_text);
//                    } else if(split_text[0].equals("C")) {
//                        new CMessage(activeUsersMap, networkUtil, split_text);
//                    } else{
//                        networkUtil.write("Wrong Format.");
//                    }
//                }
//            }
//        } catch (IndexOutOfBoundsException e) {
//            System.out.println(e);
//        } finally {
//            networkUtil.closeConnection();
//        }
//    }
//}
