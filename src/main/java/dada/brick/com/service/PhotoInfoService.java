package dada.brick.com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dada.brick.com.dao.PhotoInfoDAO;
import dada.brick.com.vo.PhotoInfo;


@Component("photoInfoService")
public class PhotoInfoService implements DataService<PhotoInfo> {
	@Autowired
	PhotoInfoDAO dao;
	
	@Override
	public int insert(PhotoInfo input) {
		// TODO Auto-generated method stub
		return dao.insert(input);
	}
	
	public int insert(List<PhotoInfo> input) {
		return dao.insert(input);
	}

	@Override
	public int update(PhotoInfo input) {
		return dao.update(input);
	}
	public int update(List<PhotoInfo> list) {
		return dao.update(list);
	}
	public int updateProducts(List<PhotoInfo> list) {
		return dao.updateProducts(list);
	}
	@Override
	public int delete(PhotoInfo input) {
		return dao.delete(input);
	}

	@Override
	public List<PhotoInfo> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PhotoInfo> select(PhotoInfo input) {
		return dao.select(input);
	}

	@Override
	public PhotoInfo selectOne(PhotoInfo input) {
		// TODO Auto-generated method stub
		return dao.selectOne(input);
	}

	@Override
	public int count(PhotoInfo input) {
		// TODO Auto-generated method stub
		return 0;
	}

}