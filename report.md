# Project 2 Report
---

## 程式的設計
本次作業利用mmap實作I/O並比較與一般file I/O的異同。
基本實作方式為，將檔案的file descriptor(fd)傳入mmap當作起始位址，並傳入檔案大小當作映射長度。直接利用虛擬位址存取檔案。

以下分為master和slave描述：
### master：
由於master端可以事先知道檔案大小，因此可以直接把整個檔案映射到虛擬位址上，讓master device直接透過映射位址讀取檔案內容。
這個方法可以省去原本file I/O需要的buffer，因此可以少一次copy的時間(但建立mmap本身有overhead)。
### slave：
由於slave端事先不知道檔案大小，因此映射時先開啟一給定的大小(通常是page size的整數倍)，如果滿了就在開新的，直到檔案傳完為止。
但檔案本身原本是空的，如果直接把開啟的檔案拿來映射，會導致bus error。因此每次要開新的映射位址時，需要先在該檔案的對應offset位置寫入一個null character。並於檔案傳送完畢後將多出來的offset truncate掉。

## 執行的結果

以下數據為針對兩種方法，各跑十次的平均。並依據 `master`、`slave`、`fileIO`、`mmap` 分別做四張圖做比較。在處理數據時有排除極端值，有時候時間會突然變好幾百毫秒，有可能是傳輸的問題，故忽略不計。

![file IO version1](https://raw.githubusercontent.com/GaryChenMesser/os_project2_2018/master/graph/file.jpg)
![mmap version1](https://raw.githubusercontent.com/GaryChenMesser/os_project2_2018/master/graph/mmap.jpg)
![master version1](https://raw.githubusercontent.com/GaryChenMesser/os_project2_2018/master/graph/master.jpg)
![slave version1](https://raw.githubusercontent.com/GaryChenMesser/os_project2_2018/master/graph/slave.jpg)

## 比較 file I/O 跟 memory-mapped I/O，並解釋造成差異的原因

### 實驗結果
### 第一版
Time needed by file I/O is averagely less than memory-mapped I/O when transmitting smaller data. This result holds for both master and slave side. However, testing with large files greater than 62500KB, memory-mapped I/O begins to outperform file I/O in master side. 
We also do the comparison between master and slave under each approach. The performance is approximately consistent with file I/O, but slave side appears to be slower when using mmap.

Also, different number of pages mapped each time have effect on memory-mapped I/O performance. Larger number of pages yield better performance due to less mapping times, which means less overhead of `mmap()`.

### 理論分析

系統在處理 File IO 的時候會去檢查 page cache 裡面有沒有資料，如果沒有的話，就會拷貝一份 buffer 過去。

使用 mmap 的話，會先造成 page fault，然後系統會將 VMM 對應的 page 存取到記憶體中。

當處理大檔案，並隨機存取該檔案內的資料，並且重複存取該檔案裡面附近的其他區塊時，因為可以有效避開 page fault，mmap 的效率會比較高，並且因為可以少 copy 一次資料到 buffer，可以預期會有速度上提升。

但是相對的，當檔案幾乎只進行一次處理，亦即當資料不在記憶體中，mmap 造成的 page fault 其實很耗資源，反而會造成效率降低。mmap 實際使用時機比較適合長期使用該檔案，類似資料庫的使用情境，才會顯現出它的價值。

此實驗中，File IO 和 mmap 的結果差異不明顯。推估是在一次存取下的差異並不大，並且因為實驗誤差所以看不出顯著差異。

依據實驗結果，推估是因為 mmap 的初始化代價比較大，所以當檔案小的時候 file IO 效率較高，而當檔案大的時候 mmap 就略勝一籌。

## 各組員的貢獻
- 陳政曄：實作memory-mapped I/O, 撰寫報告程式設計部分
- 劉安齊：製造數據、分析結果
- 鄧聿晰：測試資料傳輸結果，產生圖表
