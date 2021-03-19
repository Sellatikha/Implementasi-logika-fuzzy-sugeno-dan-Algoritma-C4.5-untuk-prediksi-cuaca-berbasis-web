-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 21 Sep 2020 pada 10.55
-- Versi server: 10.4.6-MariaDB
-- Versi PHP: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cuaca`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_gain`
--

CREATE TABLE `tb_gain` (
  `id` int(11) NOT NULL,
  `node_id` int(11) DEFAULT NULL,
  `atribut` varchar(100) DEFAULT NULL,
  `gain` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_gain`
--

INSERT INTO `tb_gain` (`id`, `node_id`, `atribut`, `gain`) VALUES
(1, 1, 'Suhu v=23', 0),
(2, 1, 'Suhu v=26', 0),
(3, 1, 'Suhu v=40', 0),
(4, 1, 'Kelembapan v=80', 0),
(5, 1, 'Kelembapan v=88', 0),
(6, 1, 'Kelembapan v=100', 0),
(7, 1, 'Kecepatan v=5', 0),
(8, 1, 'Kecepatan v=10', 0),
(9, 1, 'Kecepatan v=20', 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_hasil`
--

CREATE TABLE `tb_hasil` (
  `id_hasil` int(11) NOT NULL,
  `id_periksa` int(10) NOT NULL,
  `id_kondisi` int(5) NOT NULL,
  `z_score` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_hasil`
--

INSERT INTO `tb_hasil` (`id_hasil`, `id_periksa`, `id_kondisi`, `z_score`) VALUES
(14, 1, 2, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_hasil_periksa`
--

CREATE TABLE `tb_hasil_periksa` (
  `id_hasil_periksa` int(11) NOT NULL,
  `id_periksa` int(10) NOT NULL,
  `id_variabel` int(4) NOT NULL,
  `id_keanggotaan` int(10) NOT NULL,
  `mem_func` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_hasil_periksa`
--

INSERT INTO `tb_hasil_periksa` (`id_hasil_periksa`, `id_periksa`, `id_variabel`, `id_keanggotaan`, `mem_func`) VALUES
(66, 1, 1, 1, 0.666667),
(67, 1, 1, 2, 0.333333),
(68, 1, 2, 6, 1),
(69, 1, 3, 8, 0.555556),
(70, 1, 3, 9, 0.444444);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_keanggotaan`
--

CREATE TABLE `tb_keanggotaan` (
  `id_keanggotaan` int(10) NOT NULL,
  `id_variabel` int(4) NOT NULL,
  `b_bawah` double NOT NULL,
  `b_tengah` double NOT NULL,
  `b_atas` double NOT NULL,
  `keterangan` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data untuk tabel `tb_keanggotaan`
--

INSERT INTO `tb_keanggotaan` (`id_keanggotaan`, `id_variabel`, `b_bawah`, `b_tengah`, `b_atas`, `keterangan`) VALUES
(1, 1, 23, 26, 26, 'RENDAH'),
(2, 1, 23, 26, 40, 'NORMAL'),
(3, 1, 26, 40, 40, 'TINGGI'),
(4, 2, 80, 88, 88, 'TINGGI'),
(5, 2, 80, 88, 100, 'NORMAL'),
(6, 2, 88, 100, 100, 'RENDAH'),
(7, 3, 3, 6, 6, 'RENDAH'),
(8, 3, 3, 6, 15, 'NORMAL'),
(9, 3, 6, 15, 15, 'TINGGI');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_keputusanc45`
--

CREATE TABLE `tb_keputusanc45` (
  `id` int(11) NOT NULL,
  `parent` varchar(255) DEFAULT NULL,
  `akar` varchar(255) DEFAULT NULL,
  `keputusan` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_keputusanc45`
--

INSERT INTO `tb_keputusanc45` (`id`, `parent`, `akar`, `keputusan`) VALUES
(1, '(var_kelembapan<=88) AND (var_suhu<=26)', '(var_kelembapan<=80)', 'CERAH'),
(2, '(var_kelembapan<=88) AND (var_suhu<=26)', '(var_kelembapan>80)', 'CERAH'),
(3, '(var_kelembapan<=88) AND (var_suhu>26) AND (var_kelembapan<=80)', '(var_kecepatan<=10)', 'CERAHBERAWAN'),
(4, '(var_kelembapan<=88) AND (var_suhu>26) AND (var_kelembapan<=80)', '(var_kecepatan>10)', 'CERAHBERAWAN'),
(5, '(var_kelembapan<=88) AND (var_suhu>26)', '(var_kelembapan>80)', 'BERAWAN'),
(6, '(var_kelembapan>88)', '(var_suhu<=26)', 'CERAHBERAWAN'),
(7, '(var_kelembapan>88)', '(var_suhu>26)', 'HUJAN');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_kesimpulan`
--

CREATE TABLE `tb_kesimpulan` (
  `id_kesimpulan` int(8) NOT NULL,
  `id_periksa` int(10) NOT NULL,
  `tgl_test` datetime NOT NULL,
  `waktu` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `z_total` float NOT NULL,
  `nama_kondisi` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_kesimpulan`
--

INSERT INTO `tb_kesimpulan` (`id_kesimpulan`, `id_periksa`, `tgl_test`, `waktu`, `username`, `z_total`, `nama_kondisi`) VALUES
(1, 1, '2020-09-21 14:13:32', 1, 'admin', 0, 'CERAH');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_klasifikasic45`
--

CREATE TABLE `tb_klasifikasic45` (
  `id` int(11) NOT NULL,
  `waktu` int(11) NOT NULL,
  `var_suhu` float NOT NULL,
  `var_kelembapan` float NOT NULL,
  `var_kecepatan` float NOT NULL,
  `kelas_hasil` varchar(255) NOT NULL,
  `id_rule` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_klasifikasic45`
--

INSERT INTO `tb_klasifikasic45` (`id`, `waktu`, `var_suhu`, `var_kelembapan`, `var_kecepatan`, `kelas_hasil`, `id_rule`) VALUES
(1, 1, 24, 80, 10, 'CERAH', 1),
(2, 2, 31, 65, 20, 'CERAHBERAWAN', 4);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_kondisi`
--

CREATE TABLE `tb_kondisi` (
  `id_kondisi` int(5) NOT NULL,
  `nama_kondisi` varchar(20) NOT NULL,
  `score` float NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_kondisi`
--

INSERT INTO `tb_kondisi` (`id_kondisi`, `nama_kondisi`, `score`, `keterangan`) VALUES
(2, 'CERAH', 5, '0 - 5 Kondisi Cerah'),
(3, 'CERAHBERAWAN', 10, '5 - 10 Kondisi Cerah Berawan'),
(4, 'BERAWAN', 15, '10 -15 Kondisi Berawan'),
(5, 'HUJAN', 20, '15  - 20 dan >20  Kondisi Hujan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_login`
--

CREATE TABLE `tb_login` (
  `username` varchar(15) NOT NULL,
  `password` varchar(60) NOT NULL,
  `stts` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_login`
--

INSERT INTO `tb_login` (`username`, `password`, `stts`) VALUES
('admin', '$2y$10$zsz6GmqP/MJihN/cLD0hKuWzSbO.wJbDfGxG55VpSNE1TAH2WV9yG', 'admin'),
('operator1', '$2y$10$hr.Hf4OkBqIMgDHotljxN.gk1FFo9t33lCaQgYX7Q4yBCg2iKNbAm', 'operator');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_periksa`
--

CREATE TABLE `tb_periksa` (
  `id_periksa` int(10) NOT NULL,
  `username` varchar(15) DEFAULT NULL,
  `var_suhu` float NOT NULL,
  `var_kelembapan` float NOT NULL,
  `var_kecepatan` float NOT NULL,
  `waktu` int(11) NOT NULL,
  `tgl_test` timestamp NOT NULL DEFAULT current_timestamp(),
  `valid` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_periksa`
--

INSERT INTO `tb_periksa` (`id_periksa`, `username`, `var_suhu`, `var_kelembapan`, `var_kecepatan`, `waktu`, `tgl_test`, `valid`) VALUES
(1, 'admin', 24, 80, 10, 1, '2020-09-21 07:13:32', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_petugas`
--

CREATE TABLE `tb_petugas` (
  `id_petugas` int(10) NOT NULL,
  `username` varchar(15) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `img` varchar(50) NOT NULL,
  `gender` enum('L','P') NOT NULL,
  `alamat` text NOT NULL,
  `hp` varchar(15) NOT NULL,
  `ket` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_petugas`
--

INSERT INTO `tb_petugas` (`id_petugas`, `username`, `nama`, `img`, `gender`, `alamat`, `hp`, `ket`) VALUES
(1, 'admin', 'admin', 'SHUCIF2AZ5KBPOT9Q3406RELJ1ND8VMGWX7Y.png', 'L', 'Yogyakarta', '07384935321', 'admin'),
(2, 'operator1', 'Operator', '54V7HJMF6P3IOB8N9QDKCZUTLS0GWX1YE2RA.png', 'L', 'Sleman', '8989', 'operator');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_rasio_gain`
--

CREATE TABLE `tb_rasio_gain` (
  `id` int(11) NOT NULL,
  `opsi` varchar(10) DEFAULT NULL,
  `cabang1` varchar(50) DEFAULT NULL,
  `cabang2` varchar(50) DEFAULT NULL,
  `rasio_gain` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_rule`
--

CREATE TABLE `tb_rule` (
  `id_rule` int(11) NOT NULL,
  `suhu` varchar(20) NOT NULL,
  `kelembapan` varchar(20) NOT NULL,
  `kecepatan` varchar(20) NOT NULL,
  `tingkat_risiko` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_trainingc45`
--

CREATE TABLE `tb_trainingc45` (
  `id` int(11) NOT NULL,
  `tanggal` varchar(255) DEFAULT NULL,
  `waktu` varchar(255) DEFAULT NULL,
  `var_suhu` float DEFAULT NULL,
  `var_kelembapan` float DEFAULT NULL,
  `var_kecepatan` float DEFAULT NULL,
  `kelas_asli` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_trainingc45`
--

INSERT INTO `tb_trainingc45` (`id`, `tanggal`, `waktu`, `var_suhu`, `var_kelembapan`, `var_kecepatan`, `kelas_asli`) VALUES
(1, '44090', '7', 24, 80, 10, 'CERAH'),
(2, '44090', '13', 31, 65, 20, 'CERAHBERAWAN'),
(3, '44090', '19', 28, 70, 10, 'CERAHBERAWAN'),
(4, '44091', '7', 26, 70, 10, 'CERAHBERAWAN'),
(5, '44091', '13', 31, 65, 20, 'CERAH'),
(6, '44091', '19', 27, 75, 10, 'CERAHBERAWAN'),
(7, '44092', '7', 25, 85, 10, 'CERAH'),
(8, '44092', '13', 31, 75, 20, 'CERAH'),
(9, '44092', '19', 26, 90, 10, 'CERAHBERAWAN'),
(10, '44093', '7', 26, 95, 10, 'CERAHBERAWAN'),
(11, '44093', '13', 31, 70, 20, 'CERAH'),
(12, '44093', '19', 27, 90, 10, 'HUJAN'),
(13, '44094', '7', 26, 85, 10, 'CERAH'),
(14, '44094', '13', 31, 80, 20, 'CERAHBERAWAN'),
(15, '44094', '19', 26, 90, 10, 'CERAHBERAWAN'),
(16, '44095', '7', 26, 95, 10, 'BERAWAN'),
(17, '44095', '13', 30, 80, 20, 'CERAHBERAWAN'),
(18, '44095', '19', 26, 90, 10, 'BERAWAN'),
(19, '44096', '7', 25, 95, 10, 'BERAWAN'),
(20, '44096', '13', 28, 85, 20, 'BERAWAN'),
(21, '44096', '19', 26, 90, 10, 'BERAWAN'),
(22, '44097', '7', 26, 90, 10, 'CERAHBERAWAN'),
(23, '44097', '13', 30, 75, 20, 'BERAWAN'),
(24, '44097', '19', 26, 85, 10, 'CERAHBERAWAN'),
(25, '44098', '7', 26, 95, 10, 'BERAWAN'),
(26, '44098', '13', 29, 75, 20, 'CERAHBERAWAN'),
(27, '44098', '19', 26, 90, 10, 'CERAHBERAWAN');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_validasi`
--

CREATE TABLE `tb_validasi` (
  `id_validasi` int(11) NOT NULL,
  `id_kesimpulan` int(8) NOT NULL,
  `id_periksa` int(10) NOT NULL,
  `tgl_test` datetime NOT NULL,
  `waktu` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `z_total` float NOT NULL,
  `nama_kondisi` varchar(20) NOT NULL,
  `validasi_pakar` varchar(20) NOT NULL,
  `keterangan` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_validasi`
--

INSERT INTO `tb_validasi` (`id_validasi`, `id_kesimpulan`, `id_periksa`, `tgl_test`, `waktu`, `username`, `z_total`, `nama_kondisi`, `validasi_pakar`, `keterangan`) VALUES
(1, 1, 1, '2020-09-21 14:13:32', 1, 'admin', 0, 'CERAH', '', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_validasic45`
--

CREATE TABLE `tb_validasic45` (
  `id` int(11) NOT NULL,
  `waktu` int(11) NOT NULL,
  `var_suhu` float NOT NULL,
  `var_kelembapan` float NOT NULL,
  `var_kecepatan` float NOT NULL,
  `kelas_asli` varchar(255) NOT NULL,
  `kelas_hasil` varchar(255) NOT NULL,
  `id_rule` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_validasic45`
--

INSERT INTO `tb_validasic45` (`id`, `waktu`, `var_suhu`, `var_kelembapan`, `var_kecepatan`, `kelas_asli`, `kelas_hasil`, `id_rule`) VALUES
(1, 1, 24, 80, 10, 'CERAH', 'CERAH', 1),
(2, 2, 31, 65, 20, 'CERAHBERAWAN', 'CERAHBERAWAN', 4);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_variabel`
--

CREATE TABLE `tb_variabel` (
  `id_variabel` int(4) NOT NULL,
  `nama_variabel` varchar(30) NOT NULL,
  `keterangan` text NOT NULL,
  `kelompok` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_variabel`
--

INSERT INTO `tb_variabel` (`id_variabel`, `nama_variabel`, `keterangan`, `kelompok`) VALUES
(1, 'Suhu', 'Temperatur (suhu udara)', 1),
(2, 'Kelembapan', 'Kelembapan Udara', 2),
(3, 'Kecepatan', 'Kecepatan Angin', 3);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_waktu`
--

CREATE TABLE `tb_waktu` (
  `id_waktu` int(11) NOT NULL,
  `tanggal` date DEFAULT NULL,
  `waktu` varchar(255) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `tb_waktu`
--

INSERT INTO `tb_waktu` (`id_waktu`, `tanggal`, `waktu`, `keterangan`) VALUES
(1, '2020-09-16', '07.00', 'Pagi'),
(2, '2020-09-16', '13.00', 'Siang'),
(3, '2020-09-16', '19.00', 'Malam'),
(4, '2020-09-17', '07.00', 'Pagi'),
(5, '2020-09-17', '13.00', 'Siang'),
(6, '2020-09-17', '19.00', 'Malam'),
(7, '2020-09-18', '07.00', 'Pagi'),
(8, '2020-09-18', '13.00', 'Siang'),
(9, '2020-09-18', '19.00', 'Malam'),
(10, '2020-09-19', '07.00', 'Pagi'),
(11, '2020-09-19', '13.00', 'Siang'),
(12, '2020-09-19', '19.00', 'Malam'),
(13, '2020-09-20', '07.00', 'Pagi'),
(14, '2020-09-20', '13.00', 'Siang'),
(15, '2020-09-20', '19.00', 'Malam');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tb_gain`
--
ALTER TABLE `tb_gain`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tb_hasil`
--
ALTER TABLE `tb_hasil`
  ADD PRIMARY KEY (`id_hasil`),
  ADD KEY `id_hasil` (`id_hasil`,`id_periksa`,`id_kondisi`,`z_score`),
  ADD KEY `id_periksa` (`id_periksa`),
  ADD KEY `id_kondisi` (`id_kondisi`) USING BTREE;

--
-- Indeks untuk tabel `tb_hasil_periksa`
--
ALTER TABLE `tb_hasil_periksa`
  ADD PRIMARY KEY (`id_hasil_periksa`),
  ADD KEY `id_hasil_periksa` (`id_hasil_periksa`,`id_periksa`,`id_variabel`,`id_keanggotaan`,`mem_func`),
  ADD KEY `id_keanggotaan` (`id_keanggotaan`),
  ADD KEY `id_variabel` (`id_variabel`),
  ADD KEY `id_periksa` (`id_periksa`);

--
-- Indeks untuk tabel `tb_keanggotaan`
--
ALTER TABLE `tb_keanggotaan`
  ADD PRIMARY KEY (`id_keanggotaan`),
  ADD KEY `id_keanggotaan` (`id_keanggotaan`,`id_variabel`,`keterangan`,`b_bawah`,`b_tengah`,`b_atas`),
  ADD KEY `id_variabel` (`id_variabel`);

--
-- Indeks untuk tabel `tb_keputusanc45`
--
ALTER TABLE `tb_keputusanc45`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tb_kesimpulan`
--
ALTER TABLE `tb_kesimpulan`
  ADD PRIMARY KEY (`id_kesimpulan`);

--
-- Indeks untuk tabel `tb_klasifikasic45`
--
ALTER TABLE `tb_klasifikasic45`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_waktu` (`waktu`);

--
-- Indeks untuk tabel `tb_kondisi`
--
ALTER TABLE `tb_kondisi`
  ADD PRIMARY KEY (`id_kondisi`),
  ADD KEY `id_kondisi` (`id_kondisi`,`nama_kondisi`) USING BTREE;

--
-- Indeks untuk tabel `tb_login`
--
ALTER TABLE `tb_login`
  ADD PRIMARY KEY (`username`),
  ADD KEY `username` (`username`,`password`,`stts`),
  ADD KEY `username_2` (`username`,`password`,`stts`);

--
-- Indeks untuk tabel `tb_periksa`
--
ALTER TABLE `tb_periksa`
  ADD PRIMARY KEY (`id_periksa`),
  ADD KEY `id_user` (`username`),
  ADD KEY `tb_periksa_ibfk_2` (`waktu`,`id_periksa`,`var_suhu`,`var_kelembapan`,`var_kecepatan`,`tgl_test`,`valid`) USING BTREE,
  ADD KEY `id_periksa` (`id_periksa`,`username`,`var_suhu`,`var_kecepatan`,`var_kelembapan`,`tgl_test`) USING BTREE,
  ADD KEY `id_periksa_2` (`id_periksa`,`username`,`var_suhu`,`var_kelembapan`,`var_kecepatan`,`tgl_test`,`valid`) USING BTREE;

--
-- Indeks untuk tabel `tb_petugas`
--
ALTER TABLE `tb_petugas`
  ADD PRIMARY KEY (`id_petugas`),
  ADD KEY `id_petugas` (`id_petugas`,`username`,`nama`,`img`,`gender`,`hp`),
  ADD KEY `username` (`username`);

--
-- Indeks untuk tabel `tb_rasio_gain`
--
ALTER TABLE `tb_rasio_gain`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tb_rule`
--
ALTER TABLE `tb_rule`
  ADD PRIMARY KEY (`id_rule`);

--
-- Indeks untuk tabel `tb_trainingc45`
--
ALTER TABLE `tb_trainingc45`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tb_validasi`
--
ALTER TABLE `tb_validasi`
  ADD PRIMARY KEY (`id_validasi`),
  ADD KEY `id_validasi` (`id_validasi`,`id_kesimpulan`,`id_periksa`,`tgl_test`,`waktu`,`username`,`z_total`,`nama_kondisi`,`validasi_pakar`,`keterangan`),
  ADD KEY `id_periksa` (`id_periksa`),
  ADD KEY `id_kesimpulan` (`id_kesimpulan`);

--
-- Indeks untuk tabel `tb_validasic45`
--
ALTER TABLE `tb_validasic45`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_waktu` (`waktu`);

--
-- Indeks untuk tabel `tb_variabel`
--
ALTER TABLE `tb_variabel`
  ADD PRIMARY KEY (`id_variabel`),
  ADD KEY `id_variabel` (`id_variabel`,`nama_variabel`);

--
-- Indeks untuk tabel `tb_waktu`
--
ALTER TABLE `tb_waktu`
  ADD PRIMARY KEY (`id_waktu`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tb_gain`
--
ALTER TABLE `tb_gain`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `tb_hasil`
--
ALTER TABLE `tb_hasil`
  MODIFY `id_hasil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT untuk tabel `tb_hasil_periksa`
--
ALTER TABLE `tb_hasil_periksa`
  MODIFY `id_hasil_periksa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT untuk tabel `tb_keanggotaan`
--
ALTER TABLE `tb_keanggotaan`
  MODIFY `id_keanggotaan` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `tb_keputusanc45`
--
ALTER TABLE `tb_keputusanc45`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `tb_kesimpulan`
--
ALTER TABLE `tb_kesimpulan`
  MODIFY `id_kesimpulan` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `tb_klasifikasic45`
--
ALTER TABLE `tb_klasifikasic45`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tb_kondisi`
--
ALTER TABLE `tb_kondisi`
  MODIFY `id_kondisi` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `tb_periksa`
--
ALTER TABLE `tb_periksa`
  MODIFY `id_periksa` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `tb_petugas`
--
ALTER TABLE `tb_petugas`
  MODIFY `id_petugas` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tb_rasio_gain`
--
ALTER TABLE `tb_rasio_gain`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tb_rule`
--
ALTER TABLE `tb_rule`
  MODIFY `id_rule` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tb_trainingc45`
--
ALTER TABLE `tb_trainingc45`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT untuk tabel `tb_validasi`
--
ALTER TABLE `tb_validasi`
  MODIFY `id_validasi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `tb_validasic45`
--
ALTER TABLE `tb_validasic45`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tb_variabel`
--
ALTER TABLE `tb_variabel`
  MODIFY `id_variabel` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tb_waktu`
--
ALTER TABLE `tb_waktu`
  MODIFY `id_waktu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `tb_hasil`
--
ALTER TABLE `tb_hasil`
  ADD CONSTRAINT `tb_hasil_ibfk_1` FOREIGN KEY (`id_kondisi`) REFERENCES `tb_kondisi` (`id_kondisi`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_hasil_ibfk_2` FOREIGN KEY (`id_periksa`) REFERENCES `tb_periksa` (`id_periksa`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tb_hasil_periksa`
--
ALTER TABLE `tb_hasil_periksa`
  ADD CONSTRAINT `tb_hasil_periksa_ibfk_1` FOREIGN KEY (`id_variabel`) REFERENCES `tb_variabel` (`id_variabel`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_hasil_periksa_ibfk_2` FOREIGN KEY (`id_keanggotaan`) REFERENCES `tb_keanggotaan` (`id_keanggotaan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_hasil_periksa_ibfk_3` FOREIGN KEY (`id_periksa`) REFERENCES `tb_periksa` (`id_periksa`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tb_keanggotaan`
--
ALTER TABLE `tb_keanggotaan`
  ADD CONSTRAINT `tb_keanggotaan_ibfk_1` FOREIGN KEY (`id_variabel`) REFERENCES `tb_variabel` (`id_variabel`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tb_klasifikasic45`
--
ALTER TABLE `tb_klasifikasic45`
  ADD CONSTRAINT `tb_klasifikasi` FOREIGN KEY (`waktu`) REFERENCES `tb_waktu` (`id_waktu`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tb_periksa`
--
ALTER TABLE `tb_periksa`
  ADD CONSTRAINT `tb_periksa_ibfk_1` FOREIGN KEY (`username`) REFERENCES `tb_login` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_periksa_ibfk_2` FOREIGN KEY (`waktu`) REFERENCES `tb_waktu` (`id_waktu`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tb_petugas`
--
ALTER TABLE `tb_petugas`
  ADD CONSTRAINT `tb_petugas_ibfk_1` FOREIGN KEY (`username`) REFERENCES `tb_login` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tb_validasi`
--
ALTER TABLE `tb_validasi`
  ADD CONSTRAINT `tb_validasi_ibfk_1` FOREIGN KEY (`id_periksa`) REFERENCES `tb_periksa` (`id_periksa`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_validasi_ibfk_2` FOREIGN KEY (`id_kesimpulan`) REFERENCES `tb_kesimpulan` (`id_kesimpulan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tb_validasic45`
--
ALTER TABLE `tb_validasic45`
  ADD CONSTRAINT `tb_validasic45_ibfk` FOREIGN KEY (`waktu`) REFERENCES `tb_waktu` (`id_waktu`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
