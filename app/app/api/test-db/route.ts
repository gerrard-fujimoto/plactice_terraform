// app/app/api/test-db/route.ts
import { NextResponse } from 'next/server';
import mysql from 'mysql2/promise';

export async function GET() {
  try {
    // ECSのタスク定義で設定した環境変数を使ってDBに接続
    const connection = await mysql.createConnection({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
    });

    // DBの現在時刻を取得する簡単なクエリを実行
    const [rows] = await connection.execute('SELECT NOW() as db_time');
    await connection.end(); // 接続を閉じる

    // 成功したらJSONで返す
    return NextResponse.json({ success: true, data: rows });
    
  } catch (error: any) {
    console.error('DB Connection Error:', error);
    // 失敗したらエラーメッセージを返す
    return NextResponse.json(
      { success: false, error: 'Database connection failed', details: error.message },
      { status: 500 }
    );
  }
}
