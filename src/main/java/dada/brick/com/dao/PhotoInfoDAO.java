package dada.brick.com.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dada.brick.com.vo.PhotoInfo;


@Repository("PhotoInfoDAO")
public class PhotoInfoDAO implements DataAccess<PhotoInfo> {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String namespace = "photo_info_sql";
	@Override
	public int insert(PhotoInfo input) {
		return sqlSession.insert(namespace + ".insert", input);
	}
	public int insert(List<PhotoInfo> input) {
		return sqlSession.insert(namespace + ".insert_list", input);
	}
	@Override
	public int update(PhotoInfo input) {
		return sqlSession.update(namespace +".update", input);
	}
	public int update(List<PhotoInfo> list) {
		return sqlSession.update(namespace +".update_list", list);
	}
	public int updateOrder(List<PhotoInfo> list) {
		return sqlSession.update(namespace +".update_order", list);
	}
	public int updateProducts(List<PhotoInfo> list) {
		return sqlSession.update(namespace +".update_list_products", list);
	}
	@Override
	public int delete(PhotoInfo input) {
		return sqlSession.delete(namespace+".delete", input);
	}
	@Override
	public List<PhotoInfo> select() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<PhotoInfo> select(PhotoInfo input) {
		return sqlSession.selectList(namespace +".select", input);
	}
	@Override
	public PhotoInfo selectOne(PhotoInfo input) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".select_one", input);
	}
	@Override
	public int count(PhotoInfo input) {
		// TODO Auto-generated method stub
		return 0;
	}
	public List<PhotoInfo> selectProducts(){
		return sqlSession.selectList(namespace +".select_products");
	}
	public PhotoInfo selectNext(PhotoInfo input) {
		return sqlSession.selectOne(namespace+".select_next", input);
	}
	public PhotoInfo selectPrev(PhotoInfo input) {
		return sqlSession.selectOne(namespace+".select_prev", input);
	}
}