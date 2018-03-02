import 'dart:async';

import 'package:amazingwallpapers/Albums.dart';

abstract class AlbumRepo {
  List<AlbumDto> getAlbumList();

  Future<List<AlbumDto>> getAlbumListAsync();
}

class AlbumDto {

  AlbumDto({String id, String niceName, String thumbnail}) {
    this.thumbnail = thumbnail;
  }

  String id;
  String niceName = "nice";
  String thumbnail;
}

class ServiceLocator {
  static AlbumRepo getAlbumRepo() {
    return new MockedAlbumRepo();
  }

  static getAlbumsPresenter(AlbumsViewLoader view) {
    return new AlbumsPresenter(view: view, albumRepo: getAlbumRepo());
  }
}

class AlbumsPresenter {
  AlbumsViewLoader _view;

  AlbumRepo _albumRepo;

  AlbumsPresenter({AlbumsViewLoader view, AlbumRepo albumRepo}) {
    _view = view;
    _albumRepo = albumRepo;
  }

  loadData() {
    _view.loadingItems();

    _albumRepo.getAlbumListAsync()
        .then((list) => _view.loadedItems(list))
        .catchError((onError) {
      _view.loadFailed("Just because");
    }
    );

  }

}


class MockedAlbumRepo extends AlbumRepo {
  List<AlbumDto> getAlbumList() {
    List list = new List<AlbumDto>();

    list.add(new AlbumDto(
        thumbnail: "https://scontent-frt3-2.cdninstagram.com/vp/99d744b652e3acbc1da4977d3a3c770c/5B45E495/t51.2885-15/e35/27892594_1977419992285579_3382350220921667584_n.jpg"));
    list.add(new AlbumDto(
        thumbnail: "https://scontent-lht6-1.cdninstagram.com/vp/80c29607484f586669b5c6a0565eb83e/5B102070/t51.2885-15/e35/28436109_2068670090078578_2891429235581255680_n.jpg"));

    list.add(new AlbumDto(
        thumbnail: "https://scontent-lht6-1.cdninstagram.com/vp/80c29607484f586669b5c6a0565eb83e/5B102070/t51.2885-15/e35/28436109_2068670090078578_2891429235581255680_n.jpg"));

    return list;
  }

  @override
  Future<List<AlbumDto>> getAlbumListAsync() {
    return new Future.value(getAlbumList());
  }
}

