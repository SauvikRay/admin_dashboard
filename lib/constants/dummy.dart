   // StreamBuilder(
                    //     stream: getShopCategoryPopupListRXobj
                    //         .getShopCategoryPopupListData,
                    //     builder: (context, AsyncSnapshot snapshot) {
                    //       if (snapshot.hasData) {
                    //         List<dynamic> data =
                    //             snapshot.data["data"]["categories"];

                    //         return ListView.builder(
                    //           scrollDirection: Axis.vertical,
                    //           itemCount: data.length,
                    //           shrinkWrap: true,
                    //           itemBuilder: (context, index) => Row(
                    //             children: [
                    //               Container(
                    //                 margin: EdgeInsets.only(bottom: 10.h),
                    //                 decoration: BoxDecoration(
                    //                     borderRadius:
                    //                         BorderRadius.circular(5.r)),
                    //                 child: Row(
                    //                   children: [
                    //                     Text(
                    //                       data[index]["id"].toString(),
                    //                     ),
                    //                     UIHelper.horizontalSpaceSmall,
                    //                     Text(
                    //                       data[index]["name"].toString(),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //               UIHelper.horizontalSpaceMedium,
                    //             ],
                    //           ),
                    //         );
                    //       } else if (snapshot.hasError) {
                    //         return Container(
                    //           child: Center(
                    //             child: loadingIndicatorCircle(context: context),
                    //           ),
                    //         );
                    //       }
                    //       return Container();
                    //     }),