<template>
  <v-container>
    <v-row>
      <p class="mainTitle mt-5 ml-4">このサイトについて</p>
    </v-row>
    <v-col cols="12">
      <p>
        お家Barは今の気分に合ったカクテルを材料から見つけられるアプリです。見つかるカクテルの材料は全てコンビニで揃えられるので、お酒を飲みたいと思ったらコンビニに行くだけで作ることが出来ます。あなたは今、どんなお酒を飲みたいですか？
      </p>
    </v-col>
    <v-col cols="12">
      <p class="subTitle mb-3">利用規約</p>
      <terms-of-service class="terms"></terms-of-service>
    </v-col>
    <v-col cols="12">
      <p class="subTitle mb-3">プライバシーポリシー</p>
      <privacy-policy class="privacy"></privacy-policy>
    </v-col>
    <v-col cols="12">
      <p class="subTitle mb-3">Amazonアソシエイトについて</p>
      <p class="afilliate">
        当サイトは、Amazon.co.jpを宣伝しリンクすることによってサイトが紹介料を獲得できる手段を提供することを目的に設定されたアフィリエイトプログラムである、Amazonアソシエイト・プログラムの参加者です。
      </p>
    </v-col>
    <v-col cols="12">
      <p class="subTitle mb-3">Google Analyticsについて</p>
      <p class="googleAnalytics">
        当サイトでは、お客様の本サイトの訪問状況を把握するためにGoogle社のサービスであるGoogle Analyticsを利用しています。当サイトでGoogle Analyticsを利用しますと、当サービス提供者が発行するクッキーをもとにして、Google 社がお客様の本サイトの訪問履歴を収集、記録、分析します。当サービス提供者は、Google 社からその分析結果を受け取り、お客様の本サイトの訪問状況を把握します。Google Analyticsにより収集、記録、分析されたお客様の情報には、特定の個人を識別する情報は一切含まれません。また、それらの情報は、Google社により同社のプライバシーポリシーに基づいて管理されます。

        お客様は、ブラウザのアドオン設定でGoogle Analyticsを無効にすることにより、当サービス提供者のGoogle Analytics利用によるお客様の情報の収集を停止することも可能です。Google Analyticsの無効設定は、Google社によるオプトアウトアドオンのダウンロードページで 「Google Analyticsオプトアウトアドオン」をダウンロードおよびインストールし、ブラウザのアドオン設定を変更することで実施することができます。なお、お客様がGoogle Analyticsを無効設定した場合、お客様が訪問する本サイト以外のウェブサイトでもGoogle Analyticsは無効になりますが、お客様がブラウザのアドオンを再設定することにより、再度Google Analyticsを有効にすることも可能です。

        Google Analyticsの利用規約に関する説明についてはGoogle Analyticsのサイトを、Google社のプライバシーポリシーに関する説明については同社のサイトをご覧下さい。

        Google Analyticsの利用規約：
        https://marketingplatform.google.com/about/analytics/terms/jp/
        Googleのプライバシーポリシー：
        https://policies.google.com/privacy?hl=ja
        Google Analyticsオプトアウトアドオン：
        https://tools.google.com/dlpage/gaoptout?hl=ja
      </p>
    </v-col>
    <v-col cols="12">
      <p>お問い合わせ先： ouchi-bar824@gmail.com</p>
    </v-col>
  </v-container>
</template>
<script>
import TermsOfService from "components/atoms/TermsOfService";
import PrivacyPolicy from "components/atoms/PrivacyPolicy";

export default{
  components:{
    TermsOfService,
    PrivacyPolicy
  }
}
</script>
<style scoped>
.mainTitle{
  font-style: normal;
  font-weight: normal;
  font-size: 28px;
  line-height: 33px;
}
.subTitle{
  font-style: normal;
  font-weight: bold;
  border-bottom:solid;
  font-size: 16px;
  line-height: 19px;
  padding-bottom: 9px;
  margin-bottom: 0;
  background-color: transparent;
}
.terms, .privacy, .afilliate, .googleAnalytics{
  max-height: 300px;
  overflow: scroll;
  background-color: white;
}
</style>
