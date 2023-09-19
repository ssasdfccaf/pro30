package com.myspring.pro30.board.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.myspring.pro30.board.vo.ArticleVO;
import com.myspring.pro30.board.vo.ImageVO;


@Repository("boardDAO")
public class BoardDAOImpl implements BoardDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List selectAllArticlesList() throws DataAccessException {
		List<ArticleVO> articlesList = articlesList = sqlSession.selectList("mapper.board.selectAllArticlesList");
		return articlesList;
	}

	// 단일 이미지 글쓰기
	@Override
	public int insertNewArticle(Map articleMap) throws DataAccessException {
		// 현재 게시글의 수 
		int articleNO = selectNewArticleNO(); // selectNewArticleNO 게시글 번호의 자동 생성, 현재 게시글의 수를 조회해서 번호 부여
		articleMap.put("articleNO", articleNO);
		sqlSession.insert("mapper.board.insertNewArticle",articleMap); // articleMap : 게시글 요소를 모두 담아 실제 DB에 반영하는 로직
		return articleNO;
	}
	
	// 추가 : 단일 이미지 답글쓰기
		@Override
		public int insertReplyNewArticle(Map articleMap) throws DataAccessException {
			// 현재 게시글의 수 
			int articleNO = selectNewArticleNO(); // selectNewArticleNO 게시글 번호의 자동 생성, 현재 게시글의 수를 조회해서 번호 부여
			articleMap.put("articleNO", articleNO);
			sqlSession.insert("mapper.board.insertReplyNewArticle",articleMap); // articleMap : 게시글 요소를 모두 담아 실제 DB에 반영하는 로직
			return articleNO;
		}
    
	
	/*
	@Override
	public void insertNewImage(Map articleMap) throws DataAccessException {
		List<ImageVO> imageFileList = (ArrayList)articleMap.get("imageFileList");
		int articleNO = (Integer)articleMap.get("articleNO");
		int imageFileNO = selectNewImageFileNO();
		for(ImageVO imageVO : imageFileList){
			imageVO.setImageFileNO(++imageFileNO);
			imageVO.setArticleNO(articleNO);
		}
		sqlSession.insert("mapper.board.insertNewImage",imageFileList);
	}
   */
	
	@Override
	public ArticleVO selectArticle(int articleNO) throws DataAccessException {
		return sqlSession.selectOne("mapper.board.selectArticle", articleNO);
	}

	// 단일 이미지 : 수정된 내용 적용
	@Override
	public void updateArticle(Map articleMap) throws DataAccessException {
		sqlSession.update("mapper.board.updateArticle", articleMap);
	}

	@Override
	public void deleteArticle(int articleNO) throws DataAccessException {
		sqlSession.delete("mapper.board.deleteArticle", articleNO);
		
	}
	
	@Override
	public List selectImageFileList(int articleNO) throws DataAccessException {
		List<ImageVO> imageFileList = null;
		imageFileList = sqlSession.selectList("mapper.board.selectImageFileList",articleNO);
		return imageFileList;
	}
	
	private int selectNewArticleNO() throws DataAccessException {
		return sqlSession.selectOne("mapper.board.selectNewArticleNO");
	}
	
	private int selectNewImageFileNO() throws DataAccessException {
		return sqlSession.selectOne("mapper.board.selectNewImageFileNO");
	}

}
