package common;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileManager {
	public String upload(String savePath, MultipartFile file) {
		String filename = file.getOriginalFilename();
		//filename =>test.txt
		String onlyFilename = filename.substring(0, filename.lastIndexOf("."));//test
		String extention = filename.substring(filename.lastIndexOf("."));//.txt
		//���� ���ε��� ���ϸ�
		String filepath = null;
		//���ϸ��� �ߺ������� �ڿ� ���� ����
		int count = 0;
		while(true) {
			if(count == 0) {
				//ù��° ������ ��� ���ں����� ����
				filepath = onlyFilename+extention;			//text.txt
			}else {
				filepath = onlyFilename+"_"+count+extention;//text_1.txt
			}
			File checkFile = new File(savePath+filepath);
			if(!checkFile.exists()) {
				break;
			}
			count++;
		}
		//���ϸ� �ߺ�üũ �� -> ���ε����ϸ� Ȯ�� -> ���Ͼ��ε�
		//2-2. �ߺ�ó���� ���� ���� ���ε�
		try {
			FileOutputStream fos = new FileOutputStream(savePath+filepath);
			//���� ����� ���� ������Ʈ�� ����
			BufferedOutputStream bos = new BufferedOutputStream(fos);
			//���Ͼ��ε�
			byte[] bytes = file.getBytes();
			bos.write(bytes);
			bos.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return filepath;
	}

	public boolean deleteFile(String savePath, String filepath) {
		File delFile = new File(savePath+filepath);
		return delFile.delete();
	}
}
