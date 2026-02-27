// app/app/page.tsx
"use client"; // ボタンのクリックなどクライアント側の処理をするおまじない
import { useState } from "react";

export default function Home() {
  const [result, setResult] = useState<string>("");
  const [loading, setLoading] = useState(false);

  const testDB = async () => {
    setLoading(true);
    setResult("接続中...");
    
    try {
      // 先ほど作ったAPIを叩く
      const res = await fetch("/api/test-db");
      const data = await res.json();
      
      // 結果を整形して画面に表示
      setResult(JSON.stringify(data, null, 2));
    } catch (err) {
      setResult("APIの呼び出しに失敗しました");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div style={{ padding: "40px", fontFamily: "sans-serif", maxWidth: "600px", margin: "0 auto" }}>
      <h1>Next.js ✕ AWS RDS 疎通テスト</h1>
      <p>下のボタンを押すと、Private SubnetにあるRDSにアクセスし、現在時刻を取得します。</p>
      
      <button
        onClick={testDB}
        disabled={loading}
        style={{
          padding: "12px 24px",
          fontSize: "16px",
          cursor: loading ? "not-allowed" : "pointer",
          backgroundColor: loading ? "#ccc" : "#0070f3",
          color: "white",
          border: "none",
          borderRadius: "8px",
          marginBottom: "24px",
          fontWeight: "bold"
        }}
      >
        {loading ? "通信中..." : "DBから時刻を取得する"}
      </button>
      
      <div style={{
        backgroundColor: "#1e1e1e",
        color: "#4af626", // ターミナルっぽい緑色
        padding: "20px",
        borderRadius: "8px",
        whiteSpace: "pre-wrap",
        minHeight: "150px",
        fontFamily: "monospace"
      }}>
        {result || "ここにAPIのレスポンスが表示されます"}
      </div>
    </div>
  );
}
