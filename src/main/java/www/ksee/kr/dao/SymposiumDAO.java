package www.ksee.kr.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import www.ksee.kr.vo.Symposium;
import www.ksee.kr.vo.SymposiumDetail;
import www.ksee.kr.vo.SymposiumTypes;

@Repository("SymposiumDAO")
public class SymposiumDAO implements DataAccess<Symposium> {
	@Autowired
	SqlSessionTemplate sqlSession;
	
	final String namespace = "symposium_sql";
	
	@Override
	public int insert(Symposium input) {
		return sqlSession.insert(namespace+".insert", input);
	}

	@Override
	public int update(Symposium input) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(Symposium input) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Symposium> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Symposium> select(Symposium input) {
		return sqlSession.selectList(namespace +".select", input);
	}

	@Override
	public Symposium selectOne(Symposium input) {
		return sqlSession.selectOne(namespace +".select_one", input);
	}

	@Override
	public int count(Symposium input) {
		return sqlSession.selectOne(namespace +".count", input);
	}
	public List<SymposiumTypes> selectSymposiumTypes(){
		return sqlSession.selectList(namespace +".select_types");
	}
	public SymposiumDetail selectSymposiumDetail(SymposiumDetail input) {
		return sqlSession.selectOne(namespace+".symposium_detail", input);
	}
	public List<SymposiumDetail> selectSymposiumDetails(SymposiumDetail input) {
		return sqlSession.selectList(namespace+".symposium_details", input);
	}
	public SymposiumDetail selectSymposiumTitle(SymposiumDetail detail) {
		return sqlSession.selectOne(namespace +".symposium_title", detail);
	}
	public int deleteSymposiumDetail(SymposiumDetail detail) {
		return sqlSession.delete(namespace +".delete_symp_detail", detail);
	}
}
