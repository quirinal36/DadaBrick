package dada.brick.com.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dada.brick.com.vo.Menus;

@Repository("MenuDAO")
public class MenuDAO implements DataAccess<Menus> {
	@Autowired
	SqlSessionTemplate sqlSession;
	
	final String namespace = "menu_sql";
	
	@Override
	public int insert(Menus input) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(Menus input) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(Menus input) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Menus> select() {
		return null;
	}

	@Override
	public List<Menus> select(Menus input) {
		return sqlSession.selectList(namespace+".select", input);
	}
	public List<Menus> select(List<Menus> list) {
		return sqlSession.selectList(namespace +".select_list", list);
	}
	@Override
	public Menus selectOne(Menus input) {
		return sqlSession.selectOne(namespace +".select_one", input);
	}

	@Override
	public int count(Menus input) {
		// TODO Auto-generated method stub
		return 0;
	}

}
