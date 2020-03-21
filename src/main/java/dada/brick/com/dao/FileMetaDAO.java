package dada.brick.com.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import dada.brick.com.vo.FileMeta;

@Repository("FileMetaDAO")
public class FileMetaDAO implements DataAccess<FileMeta> {

	@Override
	public int insert(FileMeta input) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(FileMeta input) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(FileMeta input) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<FileMeta> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<FileMeta> select(FileMeta input) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public FileMeta selectOne(FileMeta input) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int count(FileMeta input) {
		// TODO Auto-generated method stub
		return 0;
	}

}
