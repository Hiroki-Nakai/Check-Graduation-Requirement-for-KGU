package Servlet;

import java.awt.geom.Rectangle2D;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.pdfbox.text.PDFTextStripperByArea;
import org.apache.pdfbox.text.TextPosition;


class Global{
	  public static int test = 0;
	  //テスト用のpdfが入力だったらtest=1
	  //正式な成績通知書が入力だったら test=0
}


/**
 * Servlet implementation class grades
 */
@WebServlet("/CheckGrades")
@MultipartConfig(location = "")
public class CheckGrades extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckGrades() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
		rd.forward(request,  response);

		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		//pdfのファイルをPartオブジェクトとして取得
		Part part = request.getPart("submit_pdf");

		//ファイル名を取得
		//String filename = part.getSubmittedFileName();
		//String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
		//request.setAttribute("Fname", filename);

		//pdfファイルの読み込みとページ数の取得
		InputStream pdffile = part.getInputStream();
		@SuppressWarnings("resource")
		PDDocument document = new PDDocument();
		Boolean error = false;
		try{
			document = PDDocument.load(pdffile);
		}catch(Exception e){
			error = true;
		}

		double x = 0.0;
		double y = 0.0;
		double w = 0.0;
		double h = 0.0;

		//成績通知書か判定-----------------------------------------------------------------
		if (!error){
			x = 380.0;
	        y = 70.0;
	        w = 100.0;
	        h = 18.0;

	        //テスト用////////////////////////////////////////////////////
	        if ( Global.test==1 ){
	        	x = 266.0;
		        y = 67.0;
		        w = 100.0;
		        h = 20.0;
	        }
	        //////////////////////////////////////////////////////////////

	        String title_text = Get_word(x, y, w, h, document);

	        if (!(title_text.contains("成績通知書"))){
	        	error = true;
	        }
		}

		//サポートされた学部の成績表か判定
		if (!error){
			//学部・研究科の取得-----------------------------------------------------------------
	        x = 294.0;
	        y = 108.0;
	        w = 100.0;
	        h = 5.0;

	        //テスト用////////////////////////////////////////////////////
	        if ( Global.test==1 ){
		        x = 214.0;
		        y = 99.0;
		        w = 150.0;
		        h = 15.0;
	        }
	        //////////////////////////////////////////////////////////////

	        String undergraduate = Get_word(x, y, w, h, document);

	        //学部の成績でないければエラー
	        if ( !undergraduate.contains("学部")){
	        	error = true;
	        }
	        else{
		        //"学部"を除いた学部名のみを取得
		        String[] undergraduate_tmp = undergraduate.split("学部");
		        undergraduate = undergraduate_tmp[0];
		        request.setAttribute("undergraduate", undergraduate);

		        //サポート外の学部の成績表が入力された場合のエラー表示
		        String[] service = {"商","経済","社会","国際","法","文","人間福祉","教育","理工"};
		        error = true;
		        for (String sev : service){
		        	if ( sev.equals(undergraduate) ){
			        	error = false;
			        	break;
			        }
		        }
	        }
		}


		if (!error){
			//int page = document.getNumberOfPages();
			//System.out.println("総ページ数:" + page);

			//語学コードの取得-----------------------------------------------------------------
	        x = 294.0;
	        y = 138.0;
	        w = 100.0;
	        h = 20.0;

	        //テスト用////////////////////////////////////////////////////
	        if ( Global.test==1 ){
	        	x = 214.0;
		        y = 145.0;
		        w = 150.0;
		        h = 17.0;
	        }
	        //////////////////////////////////////////////////////////////

	        String lang = Get_word(x, y, w, h, document);
	        //改行ごとに処理
	        String[] lang_sep = lang.split("\n");

	        request.setAttribute("languages", lang_sep);


	        //学科の取得-----------------------------------------------------------------
	        x = 294.0;
	        y = 114.0;
	        w = 100.0;
	        h = 5.0;

	        //テスト用////////////////////////////////////////////////////
	        if ( Global.test==1 ){
		        x = 214.0;
		        y = 114.0;
		        w = 150.0;
		        h = 10.0;
	        }
	        //////////////////////////////////////////////////////////////

	        String program = Get_word(x, y, w, h, document);
	        //改行コードを削除
	        if (program.length() >= 2){
		        program = program.substring(0, program.length()-1);
	        }
	        request.setAttribute("program", program);

	        //専攻・コースの取得-----------------------------------------------------------------
	        x = 294.0;
	        y = 127.0;
	        w = 100.0;
	        h = 5.0;

	        //テスト用////////////////////////////////////////////////////
	        if ( Global.test==1 ){
		        x = 214.0;
		        y = 130.0;
		        w = 150.0;
		        h = 10.0;
	        }
	        //////////////////////////////////////////////////////////////

	        String course = Get_word(x, y, w, h, document);
	        //改行コードを削除
	        if (course.length() >= 2){
	        	course = course.substring(0, course.length()-1);
	        }
	        request.setAttribute("course", course);

	        //履修状況のテキストと座標位置を取得
	        ArrayList<String> pos = PrintTextLocations.main2(document);

	        request.setAttribute("text_pos", pos);

	        document.close();
			RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/jsp/result.jsp");
			rd.forward(request, response);
		}
		else{
			document.close();
			RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/jsp/error.jsp");
			rd.forward(request, response);
		}
	}


	//抽出対象の範囲を引数として，その範囲にある文字列を返すメソッド
	public static String Get_word(double x, double y, double w, double h, PDDocument document) throws IOException{
		 Rectangle2D area = new Rectangle2D.Double(x, y, w, h);
		 PDFTextStripperByArea stripper = new PDFTextStripperByArea();
		 //抽出対象の範囲を指定する（名前は任意）
		 stripper.addRegion("list", area);
		 //抽出対象のページから範囲ごとにテキストを抽出する（getPageに渡すpageIndexは0〜）
		 stripper.extractRegions(document.getPage(0));
		 //抽出結果を取得する(語学コードを取得)
		 String Rtext = stripper.getTextForRegion("list");

		 return Rtext;
	}

}


class PrintTextLocations extends PDFTextStripper {
	static ArrayList<String> list_pos = new ArrayList<String>();
	public static ArrayList<String> main2(PDDocument document) throws IOException{
		list_pos.clear();
		//File resource = new File("C:/Users/n_hrk928011/Downloads/OUT_5178092038260581083.pdf");

		//PDDocument document = PDDocument.load(pdf_file);
		PDFTextStripper stripper = new PrintTextLocations();
		stripper.setSortByPosition( true );
		stripper.setStartPage( 0 );
		stripper.setEndPage( document.getNumberOfPages() );
		Writer dummy = new OutputStreamWriter(new ByteArrayOutputStream());
		stripper.writeText(document, dummy);

		ArrayList<String> P = returnstr();
		return P;
	}


    public PrintTextLocations() throws IOException {
    }
    @Override
    protected void writeString(String string, List<TextPosition> textPositions) throws IOException {
        String wordSeparator = getWordSeparator();
        List<TextPosition> word = new ArrayList<>();
        for (TextPosition text : textPositions) {
            String thisChar = text.getUnicode();
            if (thisChar != null) {
                if (thisChar.length() >= 1) {
                    if (!thisChar.equals(wordSeparator)) {
                        word.add(text);
                    } else if (!word.isEmpty()) {
                        String pos1 = printWord(word);
                        if (!(pos1.equals(""))){
                        	list_pos.add(pos1);
                        }
                        word.clear();
                    }
                }
            }
        }
        if (!word.isEmpty()) {
            String pos2 = printWord(word);
            if (!(pos2.equals(""))){
            	list_pos.add(pos2);
            }
            word.clear();
        }
    }
    String printWord(List<TextPosition> word) {
        Rectangle2D boundingBox = null;
        StringBuilder builder = new StringBuilder();
        for (TextPosition text : word) {
            Rectangle2D box = new Rectangle2D.Float(text.getXDirAdj(), text.getYDirAdj(), text.getWidthDirAdj(), text.getHeightDir());
            if (boundingBox == null)
                boundingBox = box;
            else
                boundingBox.add(box);
            builder.append(text.getUnicode());
        }


        if ( Global.test==1 ){
        	//テスト用////////////////////////////////////////////////////////////////////////////////////
            if (boundingBox.getX() >= 106 && boundingBox.getY() >= 222){
            	return builder.toString() + "%" + boundingBox.getX();
            }
            else{
            	return "";
            }
            //////////////////////////////////////////////////////////////////////////////////////////////
        }else{
        	//本番用//////////////////////////////////////////////////////////////////////////////////////
            if (boundingBox.getX() >= 660 && boundingBox.getY() >= 223 && boundingBox.getY() < 506){
            	return builder.toString() + "%" + boundingBox.getX();
            }
            else{
            	return "";
            }
            //////////////////////////////////////////////////////////////////////////////////////////////
        }
    }

    static ArrayList<String> returnstr(){
    	return list_pos;
    }
}
